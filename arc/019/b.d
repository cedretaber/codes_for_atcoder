import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto A = readln.chomp.to!(char[]);
    int r;
    auto len = A.length;
    auto is_p = true;
    int dcnt;
    foreach (i; 0..len/2) {
        if (A[i] != A[len-i-1]) {
            is_p = false;
            ++dcnt;
        }
    }
    foreach (i; 0..(len+1)/2) {
        if (i == len-i-1) {
            r += is_p ? 0 : 25;
        } else {
            if (A[i] != A[len-i-1]) {
                r += (dcnt == 1 ? 24 : 25)*2;
            } else {
                r += 25*2;
            }
        }
    }
    writeln(r);
}