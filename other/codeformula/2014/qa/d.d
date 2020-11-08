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
    string S, K; get(S); get(K);
    bool['z'+1] cs;
    foreach (c; K) cs[c] = true;
    auto u = 36 - K.length;

    double r = 0, p = 1;
    foreach (c; S) {
        r += 1;
        if (!cs[c]) {
            r += 2 * (1.0 - 1.0 / p);
            p += 1;
        }
        cs[c] = true;
    }
    foreach (c; '0'..'9'+1) if (!cs[c]) r += 2 * (1.0 - 1.0 / p);
    foreach (c; 'a'..'z'+1) if (!cs[c]) r += 2 * (1.0 - 1.0 / p);
    writefln!"%.12f"(r);
}