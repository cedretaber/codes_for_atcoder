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

void main()
{
    int N, M; get(N, M);
    auto G = new int[][N];
    foreach (_; 0..M) {
        int A, B; get(A, B); --A; --B;
        G[A] ~= B;
        G[B] ~= A;
    }

    auto bs = new bool[](N);
    auto ps = new int[](N);
    long r = 1;
    foreach (i; 0..N) if (!bs[i]) {
        bs[i] = true;
        int[] hs;
        int[][] rs;
        void run(int i) {
            ps[i] = hs.length.to!int;
            hs ~= i;
            rs.length = rs.length + 1;
            foreach (j; G[i]) {
                if (bs[j]) {
                    if (ps[j] < ps[i]) rs[ps[i]] ~= ps[j];
                } else {
                    bs[j] = true;
                    run(j);
                }
            }
        }
        run(i);

        if (hs.length == 1) {
            r *= 3;
            continue;
        }

        auto ss = new int[](hs.length);
        long solve(int i) {
            if (i == hs.length) return 1;
            int s;
            foreach (j; rs[i]) s |= ss[j];
            long r;
            foreach (x; 0..3) if (!(s & (1<<x))) {
                ss[i] = 1<<x;
                r += solve(i + 1);
            }
            return r;
        }
        ss[0] = 0b001;
        r *= solve(1) * 3;
    }
    writeln(r);
}
