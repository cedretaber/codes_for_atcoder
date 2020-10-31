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
    int N, K; get(N, K);
    K = abs(K);

    auto memo = new long[](2*N+1);
    foreach (i; 2..2*N+1) {
        if (i-1 < N) {
            memo[i] = i-1;
        } else {
            auto d = (i - N - 1) * 2;
            memo[i] = i-1 - d;
        }
    }

    long r;
    foreach (a; 2..2*N+1) {
        auto b = K+a;
        if (b > N*2) break;
        r += memo[a] * memo[b];
    }
    writeln(r);
}

/*

7
1 6
2 5
3 4
4 3
5 2
6 1

N=5
2 5
3 4
4 3
5 2

2
1 1

3
1 2
2 1

4
2 2

*/