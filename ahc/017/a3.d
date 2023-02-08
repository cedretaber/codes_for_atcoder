import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;
import core.time;
import std.random;

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

alias Path = Tuple!(int, "idx", int, "u", int, "v", long, "w");
alias Edge = Tuple!(int, "idx", int, "to", long, "w");

void main()
{
    auto start_time = MonoTime.currTime;

    int N, M, D, K; get(N, M, D, K);
    auto ps = new Path[](M);
    Edge[][] G; G.length = N;
    foreach (i; 0..M) {
        int u, v; long w; get(u, v, w);
        ps[i] = Path(i, u, v, w);
        G[u - 1] ~= Edge(i, v - 1, w);
        G[v - 1] ~= Edge(i, u - 1, w);
    }

    auto memo = new long[](N);
    auto days = new int[](M);
    auto schedules = new int[](D * K); schedules[] = -1;
    auto fs = new long[](D);

    auto rnd = Xorshift(N + M + D + K);
    
    auto ns = 0.iota(N).array;
    ns[].randomShuffle(rnd);
    auto nl = ns[0..4];
    
    long calc(int d) {
        alias S = Tuple!(int, "p", long, "w");
        long res;

        foreach (start; nl) {
            auto ss = heapify!"a.w > b.w"([S(start, 0)]);
            memo[] = 10L ^^ 9;
            memo[start] = 0;

            while (!ss.empty) {
                auto s = ss.front;
                ss.popFront();
                foreach (e; G[s.p]) if (d != days[e.idx]) {
                    if (memo[e.to] > s.w + e.w) {
                        memo[e.to] = s.w + e.w;
                        ss.insert(S(e.to, s.w + e.w));
                    }
                }
            }

            res += memo[].sum();
        }

        return res;
    }

    foreach (i; 0..M) schedules[i] = i;
    schedules[].randomShuffle(rnd);
    foreach (d, i; schedules) if (i != -1) days[i] = d.to!int / K;

    auto limit = 5.dur!"seconds" + 800.dur!"msecs";

    auto f = calc(-1);

    foreach (d; 0..D) fs[d] = calc(d) - f;

    for (;;) {
        if (MonoTime.currTime - start_time > limit) break;

        auto x = uniform(0, D * K, rnd);
        auto d1 = x / K;
        auto y = uniform(0, D + K, rnd);
        auto d2 = y / K;

        if (d1 == d2) continue;
        auto m1 = schedules[x];
        auto m2 = schedules[y];
        if (m1 == m2) continue;

        swap(schedules[x], schedules[y]);
        if (m1 != -1) days[m1] = d2;
        if (m2 != -1) days[m2] = d1;
        auto f1 = calc(d1) - f;
        auto f2 = calc(d2) - f;

        if (f1 + f2 < fs[d1] + fs[d2]) {
            fs[d1] = f1;
            fs[d2] = f2;
        } else {
            swap(schedules[x], schedules[y]);
            if (m1 != -1) days[m1] = d1;
            if (m2 != -1) days[m2] = d2;
        }
    }

    writefln!"%(%d %)"(days.map!"a + 1");
}
