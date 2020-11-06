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
    int N, M; get(N, M);
    auto x = (M+1)/2;
    auto y = M/2;
    auto a = 1, b = x*2;
    while (a < b) {
        writeln(a, " ", b);
        ++a; --b;
    }
    a = x*2+1, b = x*2 + y*2 + 1;
    while (a < b) {
        writeln(a, " ", b);
        ++a; --b;
    }
}

/*

++
+ +
+  +
+   +
+    +
+     +

1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
g e c a a c e g h  f  d  b    b   d  f  h

1 2 3 4 5 6 7 8 9
a b b a c d   d c

1 2 3 4 5 6 7 8
a b b a c   c 

1 2 3 4 5 6 7 8 9 0
a b b a c d   d c

*/