module study.atcoder.ahc.017.a1;

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

alias Path = Tuple!(int, "idx", int, "u", int, "v", long, "w", int, "used");
alias Edge = Tuple!(int, "idx", int, "to", long, "w");

void main()
{
    int N, M, D, K; get(N, M, D, K);
    auto ps = new Path[](M);
    Edge[][] G; G.length = N;
    foreach (i; 0..M) {
        int u, v; long w; get(u, v, w);
        ps[i] = Path(i, u, v, w, 0);
        G[u - 1] ~= Edge(i, v - 1, w);
        G[v - 1] ~= Edge(i, u - 1, w);
    }

    alias S = Tuple!(int, "p", long, "w");
    auto memo = new long[](N);
    auto prevs = new int[](N);
    foreach (start; 0..N) {
        memo[] = long.max / 3;
        memo[start] = 0;

        auto ss = heapify!"a.w > b.w"([S(start, 0)]);
        while (!ss.empty) {
            auto s = ss.front;
            ss.popFront();
            foreach (e; G[s.p]) {
                if (memo[e.to] > s.w + e.w) {
                    memo[e.to] = s.w + e.w;
                    prevs[e.to] = e.idx;
                    ss.insert(S(e.to, s.w + e.w));
                }
            }
        }

        foreach (i; prevs) ++ps[i].used;
    }

    sort!"a.w * a.used > b.w * b.used"(ps);

    alias Day = Tuple!(int, "d", long, "w", int, "k");
    auto ds = heapify!"a.w > b.w"([Day(0, 0, 0)]);
    foreach (i; 1..D) ds.insert(Day(i, 0, 0));

    auto ans = new int[](M);
    foreach (p; ps) {
        Day d;
        do {
            d = ds.front;
            ds.popFront();
        } while (d.k == K);

        ans[p.idx] = d.d + 1;
        d.w += p.w * p.used;
        ++d.k;
        ds.insert(d);
    }

    writefln!"%(%d %)"(ans);
}
