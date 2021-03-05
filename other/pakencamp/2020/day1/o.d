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
    int N; get(N);
    uint[] AS, BS, CS; get(AS); get(BS);
    foreach (i; 0..N) CS ~= AS[i] * 2^^10 + BS[i];

    int p;
    foreach_reverse (i; 0..20) {
        if (p == N) break;
        foreach (j; p+1..N) if (CS[j] & (1 << i)) swap(CS[p], CS[j]);
        if (!(CS[p] & (1 << i))) continue;
        foreach (j; p+1..N) if (CS[j] & (1 << i)) CS[j] ^= CS[p];
        ++p;
    }

    uint r;
    foreach (x; 0..2^^p) {
        uint c;
        foreach (i; 0..p) if (x & (1 << i)) c ^= CS[i];
        r = max(r, (c >> 10) + (c % (2^^10)));
    }
    writeln(r);
}
