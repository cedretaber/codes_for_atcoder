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
    int N, Q; get(N, Q);
    long[] AA; get(AA);
    
    auto ss = new long[](N);
    auto cs = new long[](N);
    foreach (i; 0..N) {
        if (i) ss[i] = ss[i - 1];
        ss[i] += AA[i];
        if (i > 1) cs[i] = cs[i - 2];
        cs[i] += AA[i];
    }

    while (Q--) {
        long X; get(X);
        if (abs(AA[0] - X) <= abs(AA[1] - X)) {
            writeln(ss[$ - 1] - ss[N / 2 - 1]);
            continue;
        }
        if (abs(AA[$ - 1] - X) < abs(AA[$ - 2] - X)) {
            writeln(cs[N - 1]);
            continue;
        }
        int l, r = N-1;
        while (l + 1 < r) {
            auto m = (l + r) / 2;
            if (X < AA[m]) {
                r = m;
            } else {
                l = m;
            }
        }
        auto i = abs(AA[l] - X) <= abs(AA[r] - X) ? l : r;
        if (i == N - 1 || i == N - 2) {
            writeln(cs[N - 1]);
            continue;
        }
        l = i;
        r = N - 2;
        while (l + 1 < r) {
            auto m = (l + r) / 2;
            auto t = N - m - 1;
            auto a = m - i + 1;
            auto d = abs(AA[m] - X);
            if (abs(AA[0] - X) <= d) {
                a = m + 1;
            } else {
                int ll, rr = i;
                while (ll + 1 < rr) {
                    auto mm = (ll + rr) / 2;
                    if (abs(AA[mm] - X) <= d) {
                        rr = mm;
                    } else {
                        ll = mm;
                    }
                }
                a += i - rr;
            }
            if (t >= a) {
                l = m;
            } else {
                r = m;
            }
        }
        auto res = ss[N - 1] - ss[l];
        auto x = N - (N - r) * 2 - 1;
        if (x >= 0) res += cs[x];
        writeln(res);
    }
}
