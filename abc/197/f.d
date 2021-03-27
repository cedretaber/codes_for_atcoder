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
    int N, M; get(N, M);
    auto T = new int[][26][N];
    foreach (_; 0..M) {
        int A, B; char[] C; get(A, B, C); --A; --B;
        T[A][C[0] - 'a'] ~= B;
        T[B][C[0] - 'a'] ~= A;
    } 

    auto DP = new int[][](N, N);
    foreach (ref dp; DP) dp[] = int.max / 3;
    DP[0][N - 1] = 0;

    alias S = Tuple!(int, "i", int, "j", int, "t");
    auto Q = heapify!"a.t > b.t"([S(0, N - 1, 0)]);
    auto r = int.max / 3;
    while (!Q.empty) with (Q.front) {
        Q.popFront();
        static foreach (c; 0..26) if (!T[i][c].empty && !T[j][c].empty) {
            foreach (ii; T[i][c]) foreach (jj; T[j][c]) {
                if (ii == jj) {
                    r = min(r, t * 2 + 2);
                    continue;
                }
                if (i == jj && j == ii) {
                    r = min(r, t * 2 + 1);
                    continue;
                }
                if (DP[ii][jj] > t + 1) {
                    DP[ii][jj] = t + 1;
                    Q.insert(S(ii, jj, t + 1));
                }
            }
        }
    }
    writeln(r == int.max / 3 ? -1 : r);
}
