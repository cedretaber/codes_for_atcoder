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
    long B, C; get(B, C);
    if (B > 0) {
        auto a = -B - (C-1)/2, b = -B + (C-1)/2, c = B - C/2, d = B + (C-2)/2;
        if (c <= b) {
            writeln(d - a + 1);
        } else {
            writeln(b - a + 1 + d - c + 1);
        }
    } else if (B < 0) {
        auto a = B - C/2, b = B + (C-2)/2, c = -B - (C-1)/2, d = -B + (C-1)/2;
        if (c <= b) {
            writeln(d - a + 1);
        } else {
            writeln(b - a + 1 + d - c + 1);
        }
    } else {
        writeln((C-1)/2 + C/2 + 1);
    }
}

/*

B, C

B > 0 の時、

+の範囲... B - C/2 ... B + (C-2)/2
-の範囲... -B - (C-1)/2 ... -B + (C-1)/2

B < 0 の時、

-の範囲... B - C/2 ... B + (C-2)/2
+の範囲... -B - (C-1)/2 ... -B + (C-1)/2

B = 0 の時、

-C/2 ... (C-1)/2



B=0 C=5

*/