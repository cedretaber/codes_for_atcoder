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
    int n, k; get(n, k);
    char[] s; get(s);

    char[] t;
    foreach (_; 0..k) {
        t = [];
        for (int i; i < n*2; i += 2) {
            auto a = s[i % n];
            auto b = s[(i+1) % n];
            if (a == 'R') {
                if (b == 'R' || b == 'S') {
                    t ~= 'R';
                } else {
                    t ~= 'P';
                }
            } else if (a == 'S') {
                if (b == 'S' || b == 'P') {
                    t ~= 'S';
                } else {
                    t ~= 'R';
                }
            } else {
                if (b == 'P' || b == 'R') {
                    t ~= 'P';
                } else {
                    t ~= 'S';
                }
            }
        }
        s = t;
    }
    writeln(s[0]);
}

/*

RPS

     S
  P     S
 P R   S P
RP SR PS RP


RPS

1 P R S
2 P S R

*/