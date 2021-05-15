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

enum P = 10^^9L + 7;
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
    alias E = Tuple!(int, "to", long, "w");
    auto T = new E[][N];
    foreach (_; 1..N) {
        int u, v; long w; get(u, v, w); --u, --v;
        T[u] ~= E(v, w);
        T[v] ~= E(u, w);
    }
    auto ws = new long[](N);
    void run(int i, int p, long w) {
        ws[i] = w;
        foreach (n; T[i]) if (n.to != p) run(n.to, i, w ^ n.w);
    }
    run(0, -1, 0);
    long[62] bs;
    foreach (i; 0..N) foreach (j; 0..62) if (ws[i] & (1L<<j)) ++bs[j];
    long res;
    foreach (i; 0..N) foreach (j; 0..62) {
        long n = (1L << j);
        if (ws[i] & n) {
            n %= P;
            (res += (N - bs[j]) * n % P) %= P;
        } else {
            n %= P;
            (res += bs[j] * n % P) %= P;
        }
    }
    writeln(res * inv(2) % P);
}
