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
    int max_a;
    auto cs = new int[](N);
    foreach (a; readln.split.to!(int[])) {
        ++cs[a];
        max_a = max(max_a, a);
    }
    int mid;
    if (max_a%2 == 0) {
        mid = max_a/2;
        if (cs[mid] != 1) {
            writeln("Impossible");
            return;
        }
    } else {
        mid = (max_a+1)/2;
        if (cs[mid] != 2) {
            writeln("Impossible");
            return;
        }
    }
    if (cs[1..mid].any!(a => a != 0) || cs[mid+1..max_a+1].any!(a => a < 2)) {
        writeln("Impossible");
        return;
    }
    writeln("Possible");
}


/*

3 2 2 3 3

3*3
2*2

3 2 2 3
* + + *
    *

1 2 2 2 2 2 2 2 2 2
2*9
1*1

* + *
  *

1 1 2 2 2 2 2 2 2 2
2*8
1*2
* + *

* + + *
3 2 2 3

* + + + *
4 3 2 3 4

*/