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
    int N; long K; get(N, K);
    long[] AS; get(AS);

    long[] ms, ps;
    long zc;
    foreach (a; AS) {
        if (a > 0) {
            ps ~= a;
        } else if (a < 0) {
            ms ~= a;
        } else {
            ++zc;
        }
    }
    sort(ps);
    sort(ms);

    if (K <= ms.length * ps.length) {
        long l = ps[$-1] * ms[0] - 1, r;
        while (l + 1 < r) {
            auto m = (l + r) / 2;
            long c;
            foreach (p; ps) {
                if (p * ms[0] > m) continue;
                long ll, rr = ms.length;
                while (ll + 1 < rr) {
                    auto mm = (ll + rr) / 2;
                    if (p * ms[mm] <= m) {
                        ll = mm;
                    } else {
                        rr = mm;
                    }
                }
                c += rr;
            }
            if (c < K) {
                l = m;
            } else {
                r = m;
            }
        }
        writeln(r);
    } else if (K <= ms.length * ps.length + (ms.length + ps.length) * zc + zc * (zc - 1) / 2) {
        writeln(0);
    } else {
        K -= ms.length * ps.length + (ms.length + ps.length) * zc + zc * (zc - 1) / 2;
        long l = 1, r;
        if (ps.length > 1) r = max(r, ps[$-1] * ps[$-2]);
        ms.reverse();
        if (ms.length > 1) r = max(r, ms[$-1] * ms[$-2]);
        ++r;
        while (l + 1 < r) {
            auto m = (l + r) / 2;
            long c;
            void count(long[] xs) {
                if (xs.length < 2) return;
                
                foreach (i, x; xs[0..$-1]) {
                    if (x * xs[i+1] > m) continue;
                    long ll = i+1, rr = xs.length;
                    while (ll + 1 < rr) {
                        auto mm = (ll + rr) / 2;
                        if (x * xs[mm] <= m) {
                            ll = mm;
                        } else {
                            rr = mm;
                        }
                    }
                    c += rr - i - 1;
                }
            }
            count(ps);
            count(ms);
            if (c < K) {
                l = m;
            } else {
                r = m;
            }
        }
        writeln(r);
    }
}
