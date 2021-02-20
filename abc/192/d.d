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

import std.bigint;

void main()
{
    char[] X; get(X);
    ulong M; get(M);

    if (X.length == 1) {
        auto x = X[0] - '0';
        return writeln(x > M ? 0 : 1);
    }

    ulong l, r = M;
    foreach (c; X) l = max(l, c - '0' + 1);

    auto x = BigInt("0");
    foreach (c; X) {
        x *= l;
        x += c - '0';
    }
    if (x > M) return writeln(0);
    auto left = l - 1;
    
    x = BigInt("0");
    foreach (c; X) {
        x *= r;
        x += c - '0';
    }
    if (x <= M) return writeln(r - left);

    while (l + 1 < r) {
        auto m = (l + r) / 2;
        x = BigInt("0");
        foreach (c; X) {
            x *= m;
            x += c - '0';
        }
        if (x > M) {
            r = m;
        } else {
            l = m;
        }
    }
    writeln(l - left);
}