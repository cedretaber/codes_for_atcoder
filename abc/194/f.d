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

enum P = 10L^^9 + 7;

void main()
{
    char[] N; long K; get(N, K);
    auto nn = N.map!(c => (c <= '9' ? c - '0' : c - 'A' + 10).to!long).array();
    auto len = N.length;

    auto DP = new long[][][](len + 1, 17, 2);
    DP[0][0][1] = 1;
    bool[16] ub;
    int uk;
    foreach (i, n; nn) {
        if (i) {
            foreach (x; 0..n) {
                if (ub[x]) {
                    (DP[i + 1][uk][0] += DP[i][uk][1]) %= P;
                } else {
                    (DP[i + 1][uk + 1][0] += DP[i][uk][1]) %= P;
                }
            }
        } else {
            (DP[i + 1][1][0] += n - 1) %= P;
        }

        if (!ub[n]) {
            ub[n] = true;
            DP[i + 1][uk + 1][1] = DP[i][uk][1];
            ++uk;
        } else {
            DP[i + 1][uk][1] = DP[i][uk][1];
        }

        (DP[i + 1][1][0] += DP[i][0][0] * 15) %= P;
        foreach (long k; 1..17) {
            (DP[i + 1][k][0] += DP[i][k][0] * k % P) %= P;
            if (k < 16) (DP[i + 1][k + 1][0] += DP[i][k][0] * (16 - k) % P) %= P;
        }
        DP[i + 1][0][0] = 1;
    }
    writeln((DP[len][K][0] + DP[len][K][1]) % P);
}

/*

[
    [[0, 1], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]], 
    [[1, 0], [0, 1], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]], 
    [[1, 0], [16, 0], [0, 1], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]]

[
    [[0, 1], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]], 
    [[1, 0], [14, 1], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]], 
    [[1, 0], [43, 1], [211, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]]
*/
