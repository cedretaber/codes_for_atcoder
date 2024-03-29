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

enum NS = [0,2,5,5,4,5,6,3,7,6];

void main()
{
    int N, M; get(N, M);
    int[] MS; get(MS);
    sort!"a > b"(MS);

    auto DP = new int[](N + 1);
    DP[] = int.min / 3;
    DP[0] = 0;
    foreach (i; 0..N + 1) {
        foreach (m; MS) {
            auto n = NS[m];
            if (i - n >= 0) DP[i] = max(DP[i], DP[i - n] + 1);
        }
    }

    char[] rs;
    int k = DP[N];
    int i = N;
    while (i) {
        foreach (m; MS) {
            auto n = NS[m];
            if (i - n >= 0 && DP[i - n] == k - 1) {
                rs ~= cast(char)('0' + m);
                i -= n;
                --k;
                break;
            }
        }
    }
    writeln(rs);
}
