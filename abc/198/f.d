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

enum P = 998244353L;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

void main()
{
    long S; get(S);

    long res;
    if (S % 6 == 0) res = 1;
}

/*

全部の組み合わせは pow(6, S - 6)

同じのが
1 -> 1通り
2 -> 2通り（反対側にあるか、無いか）
3 -> 2通り（固まってるか、ぐるりとしているか）
4 -> 2通り（固まってるが、ぐるりとしているか）
5 -> 1通り（1通りのときと同じなので）
6 -> 1通り

1 1 1 1 1 1
->
　1箇所を固定して考える
　反対側に来る数字が5通り
　そこから、残りの並べ方が3!通り
　つまり 5 * 3 * 2 = 30 通り


1 1 1 1 2
->
　2個のものが対面の場合とそうでない場合
　対面の場合、残りの並べ方は 3! 通り
　そうじゃない場合、1個の1つを固定して、
　　2のうち1つが対面に来る場合、残りの並べ方は3!通り
　　1つのものが対面に来る場合、対面の選び方が3通り * 並べ方2通りで6通り
　3! + 3! + 6 = 18通り
　

1 1 2 2
->
　2個のものを固定する
　対面 * 2
　対面, 隣り合い
　隣り合い * 2
　で、3通り

1 1 1 3
->
　3個のものを固定する。
　コの字型の時、並び順は2通り（間に来るものが違う）
　固まっている時、1通り（どう並べても回転で一致）
　よって、3通り

1 2 3
->
　3個のものを固定する。
　3個がコの字になっている時、2個のものが対面か隣り合っているかで2通り
　3個が固まっている時、1通り
　よって、3通り

1 1 4
-> 2通り（異なる2つが対面か、隣り合っているか）

1 5
-> 1通り

2 2 2
-> 3通り（対面 * 3, 対面 * 1 + 隣 * 2, 隣 * 3）

2 4
-> 2通り（2の方が対面に配置されているか、隣り合っているか）

3 3
-> 2通り（互いに食い違うか、角をそれぞれ持つか

6
-> 1通り


*/
