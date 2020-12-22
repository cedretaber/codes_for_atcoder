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
    char[] S; get(S);

    bool lout, rout;

    char[] ts, ds;
    foreach (_; 0..Q) {
        char[] td; get(td);
        auto t = td[0];
        auto d = td[2];
        ts ~= t;
        ds ~= d;

        if (t == S[0] && d == 'L') lout = true;
        if (t == S[$-1] && d == 'R') rout = true;
    }

    int check(int x) {
        foreach (i; 0..Q) if (S[x] == ts[i]) {
            if (ds[i] == 'L') {
                --x;
            } else {
                ++x;
            }
            if (x == -1) {
                return -1;
            } else if (x == N) {
                return N;
            }
        }
        return x;
    }

    if (check(0) == N || check(N-1) == -1) return writeln(0);

    int mm;
    if (lout) {
        int l, r = N-1;
        while (l + 1 < r) {
            auto m = (l + r) / 2;
            if (check(m) == -1) {
                l = m;
            } else {
                r = m;
            }
        }
        mm += r;
    }
    if (rout) {
        int l, r = N-1;
        while (l + 1 < r) {
            auto m = (l + r) / 2;
            if (check(m) == N) {
                r = m;
            } else {
                l = m;
            }
        }
        mm += N - r;
    }
    writeln(N - mm);
}