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

alias S = Tuple!(long, "i", long, "t", long, "j", long, "n", long, "p");

void main()
{
    long N; int M, K; get(N, M, K);
    K -= M;
    long A, B, C; get(A, B, C);
    long T; get(T);
    S[] ss;
    foreach (_; 0..M) {
        long s; get(s); --s;
        ss ~= S(s, s * B, 0, 0, 0);
    }
    ss ~= S(N, T + 1, 0, 0, 0);
    foreach (i; 0..M) if (ss[i].t <= T) {
        auto s = ss[i];
        s.n = ss[i+1].i;
        s.j = min(ss[i].i + (T - ss[i].t) / A + 1, s.n);
        ss[i] = s;

        auto t = s.t + (s.j - s.i) * C;
        if (t > T) continue;
        auto k = min(s.j + (T - t) / A + 1, s.n);
        s.p = k - s.j;
        ss[i] = s;
    }

    long res = -1;
    auto Q = heapify!"a.p < b.p"(ss);
    while (K--) if (Q.front.p > 0) {
        auto s = Q.front;
        Q.popFront();
        res += s.j - s.i;

        auto i = s.j;
        auto t = s.t + (i - s.i) * C;
        if (t > T) continue;
        auto j = i + s.p;
        auto k = min(j + (T - (t + (j - i) * C)) / A + 1, s.n);
        Q.insert(S(i, t, j, s.n, k - j));
    }
    foreach (s; Q) if (s.j > s.i) res += s.j - s.i;
    writeln(res);
}