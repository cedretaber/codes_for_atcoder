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

alias B = Tuple!(int, "i", int, "b");

void main()
{
    int N; get(N);
    int[] aa, bb; get(aa); get(bb);
    B[] bs;
    foreach (i, b; bb) bs ~= B(i.to!int, b);
    sort!"a.b > b.b"(bs);
    int[] pp; get(pp);
    auto rp = new int[](N);
    foreach (i, ref p; pp) {
        --p;
        rp[p] = i.to!int;
    }

    int[][] ops;
    foreach (b; bs) {
        auto ai = rp[b.i]; // 実際いる場所
        auto bi = b.i; // ここに行きたい
        if (ai == bi) continue;
        if (aa[ai] <= b.b) return writeln(-1);
        auto q = pp[bi]; // 行きたい場所にいるやつ
        if (aa[bi] <= bb[q]) return writeln(-1);
        ops ~= [ai, bi];
        rp[bi] = bi;
        pp[bi] = bi;
        rp[q] = ai;
        pp[ai] = q;
    }
    writeln(ops.length);
    foreach (op; ops) writeln(op[0] + 1, " ", op[1] + 1);
}