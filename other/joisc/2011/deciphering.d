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

enum P = 10_000_000;

void main()
{
    int L; get(L);
    string S; get(S);
    auto C = new bool[26][26];
    foreach (ref c; C) c[] = true;
    int M; get(M);
    while (M--) {
        string c; get(c);
        C[c[0] - 'A'][c[2] - 'A'] = false;
    }

    auto ii = new int[][](L, 26);
    int[26] li;
    li[] = -1;
    foreach_reverse (i, cc; S) {
        auto c = cc - 'A';
        ii[i][] = li;
        li[c] = i.to!int;
    }

    auto DP = new int[](L);
    foreach_reverse (i; 0..L) {
        DP[i] = 1;
        foreach (c; 0..26) if (C[S[i] - 'A'][c] && ii[i][c] != -1) {
            (DP[i] += DP[ii[i][c]]) %= P;
        }
    }
    long r;
    foreach (i; li) if (i >= 0) {
        (r += DP[i]) %= P;
    }
    writeln(r);
}