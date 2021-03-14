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
enum PCNT = 50;

bool[PCNT+1] PS;

void prime_init()
{
    PS[] = true;
    PS[0] = false;
    PS[1] = false;
    foreach (i; 2..PCNT+1) {
        if (PS[i]) {
            auto x = i*2;
            while (x <= PCNT) {
                PS[x] = false;
                x += i;
            }
        }
    }
}

void main()
{
    prime_init();
    int[] ps;
    foreach (i; 0..PCNT+1) if (PS[i]) ps ~= i;
    int N; get(N);
    int[] AS; get(AS);
    auto bs = new ulong[](N);
    foreach (i, a; AS) foreach (j, p; ps) if (a % p == 0) bs[i] |= 1<<j;

    long Y = long.max;
    outer: foreach (x; 0..(1<<ps.length)) {
        foreach (b; bs) if (!(x & b)) continue outer;
        long y = 1;
        foreach (i, p; ps) if (x & (1<<i)) y *= p;
        Y = min(Y, y);
    }
    writeln(Y);
}
