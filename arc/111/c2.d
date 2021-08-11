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
    int[] AA, BB; get(AA); get(BB);
    alias T = Tuple!(int, "i", int, "p");
    T[] ts;
    auto b2i = new int[](N);
    foreach (i, p; readln.split.to!(int[])) {
        ts ~= T(i.to!int, p - 1);
        b2i[p - 1] = i.to!int;
    }
    sort!((a, b) => AA[a.i] < AA[b.i])(ts);
    auto i2t = new int[](N);
    foreach (i, t; ts) i2t[t.i] = i.to!int;

    alias O = Tuple!(int, "i", int, "j");
    O[] os;
    foreach (t; ts) {
        if (t.i == t.p) continue;
        if (AA[t.i] <= BB[t.p]) return writeln(-1);
        auto j = i2t[b2i[t.i]];
        auto s = ts[j];
        if (AA[s.i] <= BB[s.p]) return writeln(-1);
        os ~= O(t.i, s.i);
        ts[j].p = t.p;
        swap(b2i[t.p], b2i[s.p]);
    }
    writeln(os.length);
    foreach (o; os) writefln!"%d %d"(o.i + 1, o.j + 1);
}
