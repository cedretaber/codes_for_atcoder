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
    string S; get(S);
    if (S == "b") return writeln("1 0");
    if (S == "a") return writeln("2 0");

    auto as = new int[](S.length+1);
    auto bs = new int[](S.length+1);
    foreach (i, c; S) {
        as[i+1] = as[i];
        bs[i+1] = bs[i];
        if (c == 'a') {
            ++as[i+1];
        } else {
            ++bs[i+1];
        }
    }

    int[30] aa, bb;
    bb[1] = 1;
    aa[2] = 1;
    static foreach (i; 3..30) {
        aa[i] = aa[i-1] + aa[i-2];
        bb[i] = bb[i-1] + bb[i-2];
    }

    bool solve(int n, int k, int o) {
        if ((n == 1 || n == 2) && k) return false;
        if (n == 1 && S[o] == 'b') return true;
        if (n == 2 && S[o] == 'a') return true;

        if (as[aa[n] + bb[n] + o] - as[o] != aa[n]) return false;
        if (bs[aa[n] + bb[n] + o] - bs[o] != bb[n]) return false;

        if (k%2 == 0) {
            return solve(n-1, k/2, o) && solve(n-2, k/4, o + aa[n-1] + bb[n-1]);
        } else {
            return solve(n-2, k/4, o) && solve(n-1, k/2, o + aa[n-2] + bb[n-2]);
        }
    }

    foreach (x; 3..30) if (aa[x] + bb[x] == S.length) {
        int k;
        for (;;) {
            if (solve(x, k, 0)) return writeln(x, " ", k);
            ++k;
        }
    }
}

/*

babaa

0 1 1 2 2 2
0 0 1 1 2 3

F[1,0]F[2,0]F[1,0]F[2,0]F[2,0]
F[3,1]F[3,1]F[2,0]
F[3,1]F[4,2]
F[5,5]

5,5


*/