import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

///
struct Matrix(N, size_t height, size_t width)
{
    N M;
    N[width][height] arr;

    this(N[width][height] arr, N M = 0) {
        this.arr = arr;
        this.M = M;
    }

    pure nothrow @nogc
    Matrix!(N, height, rhs_width) opBinary(string op, size_t rhs_width)(Matrix!(N, width, rhs_width) rhs) {
        static if (op == "&") {
            N[rhs_width][height] res;
            foreach (y; 0..height) {
                foreach (x; 0..rhs_width) {
                    foreach (i; 0..width) {
                        auto s = this.arr[y][i] & rhs.arr[i][x];
                        res[y][x] ^= s;
                    }
                }
            }
            return Matrix!(N, height, rhs_width)(res, this.M);
        } else {
            static assert(0, "Operator "~op~" not implemented");
        }
    }

    pure nothrow @nogc
    Matrix!(N, height, width) opBinary(string op)(N n) {
        static if (op == "^^" && height == width) {
            N[width][height] rr;
            foreach (i; 0..width) rr[i][i] = ~0u;
            auto r = Matrix!(N, height, width)(rr, M);
            auto x = this;
            while (n) {
                if (n%2 == 1) r = r & x;
                x = x & x;
                n /= 2;
            }
            return r;
        } else {
            static assert(0, "Operator "~op~" not implemented");
        }
    }
}

Matrix!(N, h, w) matrix(N, size_t h, size_t w)(N[w][h] arr, N M = 0)
{
    return Matrix!(N, h, w)(arr, M);
}

uint[100][1] AM;
uint[100][100] MM;

void main()
{
    auto km = readln.split.to!(int[]);
    auto K = km[0];
    auto M = km[1];

    foreach (i, a; readln.split.to!(uint[])) AM[0][K-i-1] = a;
    foreach (i, c; readln.split.to!(uint[])) MM[i][0] = c;

    if (M <= K) {
        writeln(AM[0][K-M]);
        return;
    }

    auto a = matrix(AM);

    foreach (i; 0..K-1) MM[i][i+1] = ~0u;
    auto m = matrix(MM);

    m = m^^(M-K);
    auto r = a & m;
    writeln(r.arr[0][0]);
}