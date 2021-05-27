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
    int N, A, B, C; get(N, A, B, C);
    auto abc = [A, B, C];
    string[] SS; get_lines(N, SS);

    char[] rs;
    foreach (i, s; SS) {
        int j, k, x, y;
        if (s == "AB") {
            j = 0; k = 1; x = abc[0]; y = abc[1];
        } else if (s == "AC") {
            j = 0; k = 2; x = abc[0]; y = abc[2];
        } else {
            j = 1; k = 2; x = abc[1]; y = abc[2];
        }

        if (x == 0 && y == 0) {
            return writeln("No");
        } if (x == 1 && y == 1 && i != SS.length - 1) {
            auto t = SS[i + 1];
            if (s[0] == t[0] || s[0] == t[1]) {
                rs ~= "ABC"[j];
                ++abc[j];
                --abc[k];
            } else {
                rs ~= "ABC"[k];
                ++abc[k];
                --abc[j];
            }
        } else if (x < y) {
            rs ~= "ABC"[j];
            ++abc[j];
            --abc[k];
        } else {
            rs ~= "ABC"[k];
            ++abc[k];
            --abc[j];
        }
    }
    writeln("Yes");
    foreach (c; rs) writeln(c);
}
