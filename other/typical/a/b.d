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
    auto T = new int[][](1001, 1001);
    foreach (_; 0..N) {
        int lx, ly, rx, ry; get(lx, ly, rx, ry);
        T[lx][ly] += 1;
        T[lx][ry] -= 1;
        T[rx][ly] -= 1;
        T[rx][ry] += 1;
    }
    foreach (i; 0..1001) foreach (j; 0..1000) T[i][j + 1] += T[i][j];
    foreach (j; 0..1001) foreach (i; 0..1000) T[i + 1][j] += T[i][j];
    auto ks = new int[](N + 1);
    foreach (i; 0..1000) foreach (j; 0..1000) ++ks[T[i][j]];
    writefln!"%(%d\n%)"(ks[1..$]);
}
