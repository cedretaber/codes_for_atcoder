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

alias Term = Tuple!(int, "i", int, "s", int, "t");

struct User {
    int[] ts = [-1];
    Term[] terms;
    int[int] memo;
    long result;

    void tweet(int t) {
        this.ts ~= t;
    }

    void follow(int t, int x) {
        this.memo[x] = t;
    }

    void unfollow(int t, int x) {
        this.terms ~= Term(x, this.memo[x], t);
        this.memo.remove(x);
    }

    void finish(int M) {
        foreach (x, s; memo) this.terms ~= Term(x, s, M);
    }

    void solve(User[] us) {
        this.result += this.ts.length.to!int - 1;

        int bsearch(int i, int x) {
            auto ts = us[i].ts;
            auto l = 0, r = ts.length.to!int;
            while (l + 1 < r) {
                auto m = (l + r) / 2;
                if (ts[m] < x) {
                    l = m;
                } else {
                    r = m;
                }
            }
            return l;
        }

        foreach (t; terms) this.result += bsearch(t.i, t.t) - bsearch(t.i, t.s);
    }
}

void main()
{
    int N, M, K; get(N, M, K);

    auto us = 0.iota(N).map!(_ => User()).array();

    foreach (i; 0..M) {
        string s; get(s);
        if (s[0] == 't') {
            auto j = s.split[1].to!int - 1;
            us[j].tweet(i);
        } else {
            auto ss = s.split;
            auto j = ss[1].to!int - 1;
            auto k = ss[2].to!int - 1;
            if (s[0] == 'f') {
                us[j].follow(i, k);
                us[k].follow(i, j);
            } else {
                us[j].unfollow(i, k);
                us[k].unfollow(i, j);
            }
        }
    }

    foreach (ref u; us) u.finish(M);
    foreach (ref u; us) u.solve(us);
    sort!"a.result > b.result"(us);
    writeln(us[K - 1].result);
}
