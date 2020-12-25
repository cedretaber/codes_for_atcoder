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

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

long inv(long x)
{
    return pow(x, P-2);
}

void main()
{
    int N; get(N);
    auto T = new int[][N];
    foreach (_; 1..N) {
        int A, B; get(A, B); --A; --B;
        T[A] ~= B;
        T[B] ~= A;
    }

    auto all = pow(2, N);
    auto half = pow(2, N-1);

    long res, v = inv(all);
    long solve(int i, int p) {
        auto x = (half + 1) % P;
        long s;
        foreach (j; T[i]) if (j != p) {
            auto q = solve(j, i);
            s += q;
            (x += (pow(2, q) - 1 + P) % P) %= P;
        }
        (x += (pow(2, N - s - 1) - 1 + P) % P) %= P;
        (res += (all - x + P) % P * v % P) %= P;
        return s + 1;
    }
    solve(0, -1);
    writeln(res);
}