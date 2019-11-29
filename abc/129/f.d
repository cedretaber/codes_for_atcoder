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
    auto labm = readln.split.to!(long[]);
    auto L = labm[0];
    auto A = labm[1];
    auto B = labm[2];
    auto M = labm[3];

    long[18] CS;
    if (A < 10) CS[0] = (10-A-1)/B+1;
    foreach (i; 1..18) {
        auto dm = 10L^^(i+1)-1-A;
        if (dm < 0) continue;
        auto last = B*(L-1);
        CS[i] = ((dm > last) ? last : dm)/B+1;
        foreach (j; 0..i) CS[i] -= CS[j];
        if (dm >= last) break;
    }

    long[3][1] xss = [[0, A, 1]];
    auto xs = matrix(xss, M);

    foreach (i, d; CS) {
        long[3][3] cm = [
            [(10L^^(i+1)%M).to!long, 0, 0],
            [1L, 1, 0],
            [0L, B, 1]
        ];
        auto m = matrix(cm, M);
        m = m^^d;
        xs = xs * m;
    }
    writeln(xs.arr[0][0]);
}