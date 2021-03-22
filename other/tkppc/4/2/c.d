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
    long A, B; get(A, B);
    switch (B % 4) {
        case 0: return writeln("Devil");
        case 1:
        case 2: return writeln("Angel");
        default: writeln(A % 2 == 0 ? "Devil" : "Angel");
    }
}

/*

0
  0 1 2 3 4 5 6 7 8 9 | B
0 D A A D D A A D D A
1 D A A A D A A A D A
2 D A A D D A A D D A
3 D A A A D A A A D A
4 D A A D D A A D D A
5 D A A A D A A A D A
6 D A A D D A A D D A
7 D A A A D A A A D A
8 D A A D D A A D D A
9 D A A A D A A A D A
-
A

1
  0 1 2 3 4 5 6 7 8 9 | B
0 A D D A A D D A A D
1 A A D A A A D
2 A D D A A D D
3 A A D A A A D
4 A D D A A D D
5 A A D A A A D
6 A D D A A D D
7 A A D A A A D
8 A D D A A D D
9 A A D A A A D
-
A

*/
