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
    char[][] MAP; get_lines(N, MAP);

    auto R = new int[][](N+2, N+2);
    foreach (i; 1..N) foreach (j; 1..N+1) {
        auto n = R[i-1][j] + R[i][j-1] + R[i][j+1];
        if ((MAP[i-1][j-1] == '.' && n%2 == 1) || (MAP[i-1][j-1] == '#' && n%2 == 0)) R[i+1][j] = 1;
    }
    writefln!"%-(%s\n%)"(R[1..$-1].map!(l => l[1..$-1].map!`".#"[a]`));
}

/*

##.
###
##.

abc
def
ghi

b+d = 1
a+e+c = 1
b+f = 0
a+e+g = 1
b+d+f+h = 1
c+e+i = 1
d+h = 1
e+g+i = 1
f+h = 0

b=1の時、
d=0
f=1
h=1

a=1,e=1の時
g=1
i=1
c=1

##.
###
##.

...
##.
...

###
.##
###

...
##.
...

##.
###
##.

*/