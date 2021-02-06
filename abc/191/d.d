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

/// √x 以下の最大の整数
long int_sqrt(long x)
{
    if (x < 0) return -1;
    if (x == 0) return 0;

    long l = 1, r = int.max.to!long + 1;
    while (l + 1 < r) {
        auto m = (l + r) / 2;
        if (m^^2 > x) {
            r = m;
        } else {
            l = m;
        }
    }
    
    return l;
}

/// n 以上の最小の m の倍数
long ceil_to(long n, long m)
{
    if (n >= 0) return (n + m - 1) / m * m;
    return -(-n / m) * m;
}

/// n 以下の最大の m の倍数
long floor_to(long n, long m)
{
    if (n >= 0) return n / m * m;
    return (n - m + 1) / m * m;
}

enum P = 10000L;

void main()
{
    double XX, YY, RR; get(XX, YY, RR);
    auto X = round(XX * P).to!long;
    auto Y = round(YY * P).to!long;
    auto R = round(RR * P).to!long;
    auto r2 = R^^2;
    long res;
    foreach (long x; -10^^5*2..10^^5*2+1) {
        auto rx = int_sqrt(r2 - (x * P - X)^^2);
        if (rx < 0) continue;
        res += floor_to(Y + rx, P) / P - ceil_to(Y - rx, P) / P + 1;
    }
    writeln(res);
}

/*

(x - X)^2 + (y - Y)^2 = r^2

(y - Y)^2 = r^2 - (x - X)^2

y = Y ± √(r^2 - (x - X)^2)

*/