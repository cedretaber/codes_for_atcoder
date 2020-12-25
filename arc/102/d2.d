import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;
import core.bitop;

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
    int L; get(L);
    bool[] bs;
    auto l = L;
    while (l) {
        bs ~= !!(l & 1);
        l >>= 1;
    }
    bs.reverse();

    int[] us, vs, cs;

    foreach (i; 1..bs.length.to!int) {
        us ~= i; us ~= i;
        vs ~= i + 1; vs ~= i + 1;
        cs ~= 0;
        cs ~= 1 << (bs.length - i - 1);
    }

    if (popcnt(L) != 1) {
        foreach (i; 1..bs.length.to!int) if (bs[i]) {
            int x;
            foreach (j, b; bs[0..i]) if (b) x |= 1 << (bs.length - j - 1);
            if (x) {
                us ~= 1;
                vs ~= i + 1;
                cs ~= x;
            }
        }
    }

    writeln(bs.length, " ", cs.length);
    foreach (i; 0..cs.length) writeln(us[i], " ", vs[i], " ", cs[i]);
    return;
}