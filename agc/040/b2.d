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

alias P = Tuple!(int, "l", int, "r");

void main()
{
    int N; get(N);
    P[] ps; get_lines(N, ps);
    auto rbt = redBlackTree!("a.r < b.r", true)(ps.dup);
    auto rbs = redBlackTree!("a.r < b.r", true)([P(0, 0)]);
    rbs.removeFront();
    sort!"a.l == b.l ? a.r > b.r : a.l < b.l"(ps);
    int max_r;
    foreach (p; ps[0..$-1]) {
        rbt.removeKey(p);
        rbs.insert(p);
        max_r = max(max_r, max(0, rbs.front.r - p.l + 1) + max(0, rbt.front.r - ps[$-1].l + 1));
        max_r = max(max_r, max(0, rbs.back.r - p.l + 1) + max(0, min(rbt.front.r, rbs.front.r) - ps[$-1].l + 1));
    }
    writeln(max_r);
}