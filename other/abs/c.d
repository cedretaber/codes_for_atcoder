import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits;

    static if (args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
            args[0] = readln.split.to!Arg;
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

void main()
{
    int N; get(N);
    int[] AS; get(AS);
    auto res = int.max;
    foreach (a; AS) {
        int r;
        while (a%2 == 0) {
            a /= 2;
            ++r;
        }
        res = min(res, r);
    }
    writeln(res);
}