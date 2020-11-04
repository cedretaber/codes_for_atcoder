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

enum ii = ["AB": [0, 1], "AC": [0, 2], "BC": [1, 2]];
enum cs = ["A", "B", "C"];

void main()
{
    int N, A, B, C; get(N, A, B, C);
    int[] abc = [A, B, C];
    string[] ss; get_lines(N, ss);
    string[] rs;
    foreach (x, s; ss) {
        auto i = ii[s][0], j = ii[s][1];
        if (abc[i] > abc[j]) {
            --abc[i];
            ++abc[j];
            rs ~= cs[j];
        } else if (abc[i] < abc[j]) {
            ++abc[i];
            --abc[j];
            rs ~= cs[i];
        } else if (abc[i] == 0) {
            writeln("No");
            return;
        } else if (x == N-1) {
            rs ~= cs[i];
        } else {
            auto k = ii[ss[x+1]][0], l = ii[ss[x+1]][1];
            if (i == k || i == l) {
                ++abc[i];
                --abc[j];
                rs ~= cs[i];
            } else {
                --abc[i];
                ++abc[j];
                rs ~= cs[j];
            }
        }
    }
    writefln!"Yes\n%-(%s\n%)"(rs);
}