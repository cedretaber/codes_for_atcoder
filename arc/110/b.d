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
    char[] T; get(T);

    if (N == 1) {
        writeln(T[0] == '0' ? 10L^^10 : 10L^^10 * 2);
    } else if (N == 2) {
        writeln(
            T == "10" || T == "11" ? 10L^^10 :
            T == "01" ? 10L^^10 - 1 : 0
        );
    } else {
        if (T[0] == '0') {
            T = ['1', '1'] ~ T;
        } else if (T[0] == '1' && T[1] == '0') {
            T = ['1'] ~ T;
        }
        if (T[$-1] == '1' && T[$-2] == '1') {
            T ~= '0';
        } else if (T[$-1] == '1') {
            T ~= ['1', '0'];
        }

        if (T.length % 3 != 0) {
            writeln(0);
            return;
        }
        for (int i; i < T.length; i += 3) {
            if (T[i..i+3] != "110") {
                writeln(0);
                return;
            }
        }
        writeln(10L^^10 - T.length / 3 + 1);
    }
}