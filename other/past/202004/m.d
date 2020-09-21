import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
            args[0] = readln.split.to!Arg;
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

debug {
    enum C_MAX = 10;
} else {
    enum C_MAX = 10^^5;
}

void main()
{
    int D, L, N; get(D, L, N);
    long[] CS; get(CS);

    long count(long from, long to) {
        return (to - from - 1) / L + 1;
    }

    auto css = new long[][C_MAX];
    foreach (i, ref c; CS) {
        c -= 1;
        css[c] ~= i.to!long;
    }
    auto dss = new long[][C_MAX];
    auto ess = new long[][](C_MAX, 32);
    foreach (k, cs; css) {
        if (cs.empty) continue;

        dss[k].length = cs.length;
        auto ds = dss[k];
        auto es = ess[k];

        long last_c = cs[$-1] - D;
        foreach (i; 0..cs.length) {
            if (i) ds[i] = ds[i-1];
            ds[i] += count(last_c, cs[i]);
            last_c = cs[i];
        }
        auto e = ds[$-1];
        foreach (i; 0..32) {
            if (e * 2L^^i <= 10L^^9) {
                es[i] = e * 2L^^i;
            } else {
                es[i] = -1;
            }
        }
    }
    debug writeln(css);
    debug writeln(dss);
    debug writeln(ess);

    // 1週目の食事回数、1週目の最初の好みの食事のインデックス、その食事に至るまでの食事回数
    alias R1 = Tuple!(long, long, long);
    R1 resolve_first_cycle(long F, long[] cs, long[] ds) {
        if (cs[0] == F) {
            return R1(ds[$-1] - ds[0] + 1, 0, 0);
        } else if (F < cs[0]) {
            auto r1 = count(F, cs[0]);
            return R1(ds[$-1] - ds[0] + r1 + 1, 0, r1);
        } else if (F > cs[$-1]) {
            auto r1 = count(F-D, cs[0]);
            return R1(ds[$-1] - ds[0] + r1 + 1, 0, r1);
        } else {
            int l, r = cs.length.to!int-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (cs[m] < F) {
                    l = m;
                } else {
                    r = m;
                }
            }
            if (cs[r] == F) {
                return R1(ds[$-1] - ds[r] + 1, r, 0);
            } else {
                auto r1 = count(F, cs[r]);
                return R1(ds[$-1] - ds[r] + r1 + 1, r, r1);
            }
        }
    }

    // 残りの食事回数、好きな食事の回数合計
    alias R2 = Tuple!(long, long);
    R2 resolve_loop_cycle(long T, long M, long[] es) {
        long R;
        foreach_reverse (i, e; es) if (e != -1 && T >= e) {
            R += M * 2L^^i;
            T -= e;
        }
        return R2(T, R);
    }

    int x;
    while (N--) {
        debug writeln("TestCase #", ++x);
        
        long K, F, T; get(K, F, T);
        --K; --F;
        debug writefln!"K=%s, F=%s, T=%s"(K, F, T);

        auto cs = css[K];
        auto ds = dss[K];
        auto es = ess[K];
        if (cs.empty) {
            writeln(0);
            continue;
        }

        auto res1 = resolve_first_cycle(F, cs, ds);
        auto t1 = res1[0], f1 = res1[1], r1 = res1[2];
        debug writefln!"t1=%s, f1=%s, r1=%s"(t1, f1, r1);

        if (T <= t1) {
            if (T <= r1) {
                writeln(0);
            } else {
                auto offset = -ds[f1] + r1 + 1;
                auto l = f1, r = ds.length.to!long;
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (ds[m] + offset <= T) {
                        l = m;
                    } else {
                        r = m;
                    }
                }
                writeln(r - f1);
            }
            continue;
        }

        auto res2 = resolve_loop_cycle(T - t1, cs.length.to!long, es);
        T = res2[0];
        auto res = cs.length.to!long - f1 + res2[1];

        if (T < ds[0]) {
            writeln(res);
        } else {
            int l, r = cs.length.to!int-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (ds[m] <= T) {
                    l = m;
                } else {
                    r = m;
                }
            }
            writeln(res + r);
        }
    }
}
