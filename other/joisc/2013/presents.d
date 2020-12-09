import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
          static if (isSomeChar!(ElementType!Arg)) {
            args[0] = readln.chomp.to!Arg;
          } else {
            args[0] = readln.split.to!Arg;
          }
        } else static if (isTuple!Arg) {
            auto input = readln.split;
            static foreach (i; 0..Fields!Arg.length) {
                args[0][i] = input[i].to!(Fields!Arg[i]);
            }
        } else {
            args[0] = readln.chomp.to!Arg;
        }
    } else {
        auto input = readln.split;
        assert(input.length == Args.length);

        static foreach (i; 0..Args.length) {
            args[i] = input[i].to!(Args[i]);
        }
    }
}

void get_lines(Args...)(size_t N, ref Args args)
{
    import std.traits, std.range;

    static foreach (i; 0..Args.length) {
        static assert(isArray!(Args[i]));
        args[i].length = N;
    }

    foreach (i; 0..N) {
        static if (Args.length == 1) {
            get(args[0][i]);
        } else {
            auto input = readln.split;
            static foreach (j; 0..Args.length) {
                args[j][i] = input[j].to!(ElementType!(Args[j]));
            }
        }
    }
}

int rev(int x)
{
    return x == 1 ? 2 : 1;
}

void main()
{
    int N; get(N);
    int[] AS; long[] BS, CS, DS; get_lines(N, AS, BS, CS, DS);
    foreach (ref a; AS) --a;

    auto R = new int[](N);
    foreach (i; 0..N) if (R[i] == 0) {
        size_t[int] fp;
        int[] hs;
        void walk(int i) {
            auto j = AS[i];

            if (R[j]) {
                R[i] = CS[j] >= DS[j] ? R[j] : rev(R[j]);
                return;
            }

            if (j !in fp) {
                fp[i] = hs.length;
                hs ~= i;
                walk(j);
                if (R[i] == 0) R[i] = CS[j] >= DS[j] ? R[j] : rev(R[j]);
                return;
            }

            hs = hs[fp[j]..$];
            alias P = Tuple!(size_t, "i", long, "d");
            P[] ps;
            R[i] = 1;
            foreach_reverse (idx, h; hs) {
                auto k = AS[h];
                R[h] = CS[k] >= DS[k] ? R[k] : rev(R[k]);
                ps ~= P(idx, abs(CS[k] - DS[k]) * BS[h]);
            }
            if (R[i] == R[j] && CS[j] >= DS[j]) return;
            if (R[i] != R[j] && CS[j] <= DS[j]) return;
            ps ~= P(hs.length, abs(CS[j] - DS[j]) * BS[i]);
            sort!"a.d < b.d"(ps);
            foreach_reverse (idx, h; hs) {
                auto k = AS[h];
                if (idx == ps[0].i) {
                    R[h] = CS[k] < DS[k] ? R[k] : rev(R[k]);
                } else {
                    R[h] = CS[k] >= DS[k] ? R[k] : rev(R[k]);
                }
            }
            return;
        }
        walk(i);
    }

    long res;
    foreach (i; 0..N) {
        auto j = AS[i];
        res += (R[i] == R[j] ? CS[j] : DS[j]) * BS[i];
    }
    writeln(res);
}