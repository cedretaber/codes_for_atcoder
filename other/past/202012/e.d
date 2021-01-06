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
    int H, W; get(H, W);
    char[][] S, T;
    foreach (_; 0..H) S ~= readln.chomp.to!(char[]);
    foreach (_; 0..H) T ~= readln.chomp.to!(char[]);
    int len;
    if (H > W) {
        foreach (ref t; T) t.length = H;
        len = H;
    } else {
        foreach (_; 0..W-H) T ~= new char[](W);
        len = W;
    }

    foreach (_; 0..4) {
        foreach (i1; 1-len..H) foreach (j1; 1-len..W) {
            foreach (i2; 0..len) foreach (j2; 0..len) {
                auto i = i1 + i2;
                auto j = j1 + j2;
                if (i < 0 || j < 0 || i >= H || j >= W) {
                    if (T[i2][j2] == '#') goto ng;
                } else {
                    if (S[i][j] == '#' && T[i2][j2] == '#') goto ng;
                }
            }
            return writeln("Yes");
            ng:
        }

        auto tt = new char[][](len, len);
        foreach (i; 0..len) foreach (j; 0..len) {
            tt[j][len - i - 1] = T[i][j];
        }
        T = tt;
    }
    writeln("No");
}