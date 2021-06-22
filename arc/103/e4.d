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
    char[] S; get(S);
    auto N = S.length.to!int;
    if (S[0] == '0' || S[$ - 1] == '1') return writeln(-1);
    {
        int i, j = N - 2;
        while (i < j) {
            if (S[i] != S[j]) return writeln(-1);
            ++i; --j;
        }
    }

    int[] aa, bb, cc; aa.reserve(N); bb.reserve(N); cc.reserve(N);
    foreach (i; 0..N - 1) {
        if (S[i] == '0') {
            cc ~= i + 1;
        } else {
            foreach (c; cc) {
                aa ~= i + 1;
                bb ~= c;
            }
            cc = [i + 1];
        }
    }
    foreach (c; cc) {
        aa ~= N;
        bb ~= c;
    }

    foreach (i; 0..N - 1) writeln(aa[i], " ", bb[i]);
}
