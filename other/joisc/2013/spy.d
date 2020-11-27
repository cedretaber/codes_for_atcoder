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
    auto Tj = new int[][N];
    auto Ti = new int[][N];
    int pj, pi;
    foreach (i; 0..N) {
        int P, Q; get(P, Q);
        if (P) {
            Tj[P-1] ~= i;
        } else {
            pj = i;
        }
        if (Q) {
            Ti[Q-1] ~= i;
        } else {
            pi = i;
        }
    }
    int walk(int i, int p, ref int[][] es, int[][] T) {
        es[0][i] = p;
        foreach (j; T[i]) p = walk(j, p + 1, es, T);
        es[1][i] = p + 1;
        return p;
    }

    auto ej = new int[][](2, N+1);
    auto ei = new int[][](2, N+1);
    walk(pj, 0, ej, Tj);
    walk(pi, 0, ei, Ti);

    auto DP = new int[][](N+1, N+1);
    while (M--) {
        int r, s; get(r, s); --r; --s;
        DP[ej[0][r]][ei[0][s]] += 1;
        DP[ej[1][r]][ei[0][s]] -= 1;
        DP[ej[0][r]][ei[1][s]] -= 1;
        DP[ej[1][r]][ei[1][s]] += 1;
    }
    foreach (i; 0..N) foreach (j; 0..N) DP[i][j+1] += DP[i][j];
    foreach (j; 0..N) foreach (i; 0..N) DP[i+1][j] += DP[i][j];

    foreach (i; 0..N) writeln(DP[ej[0][i]][ei[0][i]]);
}

// void main()
// {
//     int N, M; get(N, M);
//     auto Tj = new int[][N];
//     auto Ti = new int[][N];
//     int pj, pi;
//     foreach (i; 0..N) {
//         int P, Q; get(P, Q);
//         if (P) Tj[P-1] ~= i;
//         if (Q) {
//             Ti[Q-1] ~= i;
//         } else {
//             pi = i;
//         }
//     }

//     auto ls = new int[](N);
//     auto rs = new int[](N);
//     int p;
//     void walk(int i) {
//         ls[i] = p;
//         foreach (j; Ti[i]) {
//             ++p;
//             walk(j);
//         }
//         rs[i] = p;
//     }
//     walk(pi);

//     auto RS = new int[][](N, N);
//     while (M--) {
//         int r, s; get(r, s); --r; --s;
//         ++RS[r][s];
//     }

//     auto res = new int[](N);
//     auto as = new int[](N);
//     auto DP = new int[](N+1);
//     void calc(int i) {
//         if (p) DP[p] += DP[p-1];
//         as[i] = DP[p];
//         foreach (j; Ti[i]) {
//             ++p;
//             calc(j);
//         }
//     }
//     void add(int i) {
//         res[i] += as[i];
//         foreach (j; Tj[i]) add(j);
//     }
//     foreach (i; 0..N) {
//         DP[] = 0;
//         foreach (j; 0..N) {
//             DP[ls[j]] += RS[i][j];
//             DP[rs[j]+1] -= RS[i][j];
//         }
//         p = 0;
//         calc(pi);
//         add(i);
//     }
//     writefln!"%(%d\n%)"(res);
// }