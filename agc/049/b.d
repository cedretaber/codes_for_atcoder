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
    int[] S;
    foreach (i, c; readln.chomp) if (c == '1') S ~= i.to!int;
    char[] T; get(T);
    
    long res;
    foreach (i; 0..N) {
        if (T[i] == '1') {
            if (S.empty) return writeln(-1);
            if (S.front != i) res += S.front - i;
            S.popFront();
        } else {
            if (S.empty || S.front != i) continue;
            S.popFront();
            if (S.empty) return writeln(-1);
            res += S.front - i;
            S.popFront();
        }
    }
    writeln(S.empty ? res : -1);
}

/*

5
10111
01010

10111

11011
00011
00101
01001
01010


3
001
110

001
010
100

*/