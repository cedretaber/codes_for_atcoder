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

alias P = Tuple!(int, "x", int, "y");

void main()
{
    int L, N; get(L, N);
    P[] ps; get_lines(N, ps);
    sort!"a.y - a.x < b.y - b.x"(ps);
    int last = -L;
    long s;
    int[] qs, rs;
    foreach (p; ps) if (last != p.y - p.x) {
        if ((p.x + p.y) % 2 == 0) {
            qs ~= p.y - p.x;
        } else {
            rs ~= p.y - p.x;
        }
        last = p.y - p.x;
        s += L - abs(p.x - p.y);
    }
    // writeln(s);
    sort!((a, b) => L - abs(a.x + a.y + 1 - L) > L - abs(b.x + b.y + 1 - L))(ps);
    int l1, l2, r1 = qs.length.to!int-1, r2 = rs.length.to!int-1;
    bool[int] memo;
    foreach (p; ps) if (p.x + p.y !in memo) {
        // writeln(p);
        memo[p.x + p.y] = true;
        auto d = abs(p.x + p.y + 1 - L);
        if ((p.x + p.y) % 2 == 0) {
            while (l1 < r1 && qs[l1] < -L + 1 + d) ++l1;
            while (l1 < r1 && qs[r1] > L - 1 - d) --r1;
            s += (L - d) - (r1 - l1 + 1);
            // writefln!"qr=%d d=%d l=%d r=%d sum=%d"(0, d, l1, r1, (L - d) - (r1 - l1 + 1));
        } else {
            while (l2 < r2 && rs[l2] < -L + 1 + d) ++l2;
            while (l2 < r2 && rs[r2] > L - 1 - d) --r2;
            s += (L - d) - (r2 - l2 + 1);
            // writefln!"qr=%d d=%d l=%d r=%d sum=%d"(1, d, l2, r2, (L - d) - (r2 - l2 + 1));
        }
    }
    writeln(s);
}