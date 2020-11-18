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

alias R = Tuple!(int, "l", int, "r");

void main()
{
    int N, M; get(N, M);
    int last;
    long max_d;
    R[] rs;
    foreach (a; readln.split.to!(int[])) {
        if (last) {
            auto l = a > last ? last : last - M;
            rs ~= R(l, a);
            max_d += a - l;
            if (a < last) rs ~= R(last, M + a);
        }
        last = a;
    }
    sort!"a.l < b.l"(rs);
    auto Q = heapify!"a.r > b.r"([R(0, 0)]);
    Q.removeFront();
    long d, res = max_d;
    foreach (i; 1..M+1) {
        while (!rs.empty && rs.front.l+2 <= i) {
            auto h = rs[0];
            rs.popFront();
            Q.insert(h);
            d += i - h.l - 2;
        }
        while (!Q.empty && Q.front.r < i) {
            auto h = Q.front;
            Q.removeFront();
            d -= h.r - h.l - 1;
        }
        d += Q.length;
        res = min(res, max_d - d);
    }
    writeln(res);
}

/*

4 6
1 5 1 4

 -1 0 1 2 3 4 5 6
      + - - - +
  + - +
      + - - +

1 2 3 4 5 6 1 2
        + - +

-1 - 1
1 - 4
1 - 5

4+2+3 = 9

x=1 -1 ... 8
x=2  0
x=3 -2 ... 7
x=4 -4 ... 5

1  2  3  4  5  6  7  8  9 10  1  2  3  4  5  6  7  8  9 10
                           +  -  -  -  -  -  -  -  -  +
                        +  -  -  -  -  -  -  -  -  +
                     +  -  -  -  -  -  -  -  -  +

*/