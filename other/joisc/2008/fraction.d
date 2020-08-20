import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias F = Tuple!(int, "dividend", int, "divisor");

void main()
{
    auto mk = readln.split.to!(int[]);
    auto M = mk[0];
    auto K = mk[1];

    auto fs = heapify!((a, b) => a.dividend.to!double / a.divisor.to!double > b.dividend.to!double / b.divisor.to!double)([F(1, M)]);

    bool[F] memo, reduced;
    memo[F(1, M)] = true;

    while (!fs.empty) {
        auto h = fs.front;
        fs.popFront();
        with (h) {
            auto d = gcd(dividend, divisor);
            auto x = dividend / d;
            auto y = divisor / d;
            auto r = F(x, y);
            if (r !in reduced) {
                reduced[r] = true;
                if (--K == 0) {
                    writeln(x, " ", y);
                    return;   
                }
            }

            {
                auto f = F(dividend+1, divisor);
                if (dividend+1 < divisor && f !in memo) {
                    fs.insert(f);
                    memo[f] = true;
                }
            }
            {
                auto f = F(dividend, divisor-1);
                if (dividend < divisor-1 && f !in memo) {
                    fs.insert(f);
                    memo[f] = true;
                }
            }
        }
    }
    writeln(-1);
}