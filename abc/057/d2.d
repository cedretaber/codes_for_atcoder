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
    int N, A, B; get(N, A, B);

    long[][] pt;
    pt ~= [1];
    foreach (i; 0..N) {
        long[] l = [1];
        foreach (j; 1..i+1) {
            l ~= pt[i][j-1] + pt[i][j];
        }
        l ~= 1;
        pt ~= l;
    }

    long[] vs; get(vs);
    sort!"a > b"(vs);

    int[long] cs;
    foreach (v; vs) ++cs[v];
    if (cs[vs[0]] >= A) {
        writeln(vs[0]);
        long r;
        foreach (k; A..min(cs[vs[0]], B)+1) r += pt[cs[vs[0]]][k];
        writeln(r);
    } else {
        int[long] ds;
        double r = 0;
        foreach (v; vs[0..A]) {
            r += v;
            ++ds[v];
        }
        writefln!"%.12f"(r / A);
        writeln(pt[cs[vs[A-1]]][ds[vs[A-1]]]);
    }
}