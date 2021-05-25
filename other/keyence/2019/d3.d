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
    int N, M; get(N, M);
    int[] AA, BB; get(AA); get(BB);

    auto ab = new bool[][](2, N*M);
    foreach (a; AA) {
        if (ab[0][a-1]) {
            writeln(0);
            return;
        }
        ab[0][a-1] = true;
    }
    foreach (b; BB) {
        if (ab[1][b-1]) {
            writeln(0);
            return;
        }
        ab[1][b-1] = true;
    }

    long n, m, b, r = 1;
    foreach_reverse (i; 0..N*M) {
        if (ab[0][i] && ab[1][i]) {
            n += 1;
            m += 1;
        } else if (ab[0][i]) {
            n += 1;
            (r *= m) %= P;
        } else if (ab[1][i]) {
            m += 1;
            (r *= n) %= P;
        } else {
            (r *= (m*n-b)) %= P;
        }
        b += 1;
    }
    writeln(r);
}
