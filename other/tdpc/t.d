import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

struct Matrix(size_t height, size_t width)
{
    long M;
    long[width][height] arr;

    this(long[width][height] arr, long M = 0) {
        this.arr = arr;
        this.M = M;
    }

    pure nothrow @nogc
    Matrix!(height, rhs_width) opBinary(string op, size_t rhs_width)(Matrix!(width, rhs_width) rhs) {
        static if (op == "*") {
            long[rhs_width][height] res;
            foreach (y; 0..height) {
                foreach (x; 0..rhs_width) {
                    foreach (i; 0..width) {
                        auto s = this.arr[y][i] * rhs.arr[i][x];
                        if (this.M) s %= this.M;
                        res[y][x] += s;
                        if (this.M) res[y][x] %= this.M;
                    }
                }
            }
            return Matrix!(height, rhs_width)(res, this.M);
        } else {
            static assert(0, "Operator "~op~" not implemented");
        }
    }

    pure nothrow @nogc
    Matrix!(height, width) opBinary(string op)(long n) {
        static if (op == "^^" && height == width) {
            long[width][height] rr;
            foreach (i; 0..width) rr[i][i] = 1;
            auto r = Matrix!(height, width)(rr, M);
            auto x = this;
            while (n) {
                if (n%2 == 1) r = r * x;
                x = x * x;
                n /= 2;
            }
            return r;
        } else {
            static assert(0, "Operator "~op~" not implemented");
        }
    }
}

Matrix!(h, w) matrix(size_t h, size_t w)(long[w][h] arr, long M = 0)
{
    return Matrix!(h, w)(arr, M);
}

void main()
{
    auto kn = readln.split.to!(long[]);
    auto K = kn[0];
    auto N = kn[1];
}