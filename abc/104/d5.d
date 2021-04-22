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
    char[] S; get(S);
    auto N = S.length.to!int;

    long q = 1;
    foreach (c; S) if (c == '?') (q *= 3) %= P;

    auto aa = new long[](N);
    auto cc = new long[](N);
    auto qa = new long[](N);
    auto qc = new long[](N);
    foreach (i; 0..N) {
        if (i) {
            aa[i] = aa[i - 1];
            qa[i] = qa[i - 1];
        }
        if (S[i] == 'A') ++aa[i];
        if (S[i] == '?') ++qa[i];
    }
    foreach_reverse (i; 0..N) {
        if (i < N - 1) {
            cc[i] = cc[i + 1];
            qc[i] = qc[i + 1];
        }
        if (S[i] == 'C') ++cc[i];
        if (S[i] == '?') ++qc[i];
    }

    long r;
    foreach (i; 1..N - 1) {
        if (S[i] == 'B') {
            (r += aa[i - 1] * cc[i + 1] % P * q) %= P;
            (r += qa[i - 1] * cc[i + 1] % P * q % P * inv(3) % P) %= P;
            (r += aa[i - 1] * qc[i + 1] % P * q % P * inv(3) % P) %= P;
            (r += qa[i - 1] * qc[i + 1] % P * q % P * inv(9) % P) %= P;
        }
        if (S[i] == '?') {
            (r += aa[i - 1] * cc[i + 1] % P * q % P * inv(3) % P) %= P;
            (r += qa[i - 1] * cc[i + 1] % P * q % P * inv(9) % P) %= P;
            (r += aa[i - 1] * qc[i + 1] % P * q % P * inv(9) % P) %= P;
            (r += qa[i - 1] * qc[i + 1] % P * q % P * inv(27) % P) %= P;
        }
    }
    writeln(r);
}
