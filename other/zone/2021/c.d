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
    int N; get(N);
    long[] AA, BB, CC, DD, EE; get_lines(N, AA, BB, CC, DD, EE);
    auto AE = [AA, BB, CC, DD, EE];
    int[32] S;
    auto ss = new int[](N);
    long l, r = 10^^9 + 1;
    while (l + 1 < r) {
        auto m = (l + r) / 2;
        S[] = 0;
        foreach (i; 0..N) {
            int s;
            static foreach (x; 0..5) if (AE[x][i] >= m) s |= 1<<x;
            ss[i] = s;
            ++S[s];
        }
        int[] xs;
        foreach (s, n; S) if (n > 0) xs ~= s.to!int;
        foreach (i; 0..xs.length) {
            if (xs[i] == 0b11111) goto ok;
            foreach (j; i + 1..xs.length) {
                if ((xs[i] | xs[j]) == 0b11111) goto ok;
                foreach (k; j + 1..xs.length) if ((xs[i] | xs[j] | xs[k]) == 0b11111) goto ok;
            }
        }
        r = m;
        continue;
        ok:
        l = m;
    }
    writeln(l);
}
