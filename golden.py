import random

class Golden:

    alu_sel = None
    A =  None
    B = None
    Expected = None
    
    def __init__(self):
        random.seed(40)
    def convert(self, A):
        A = A & 0xFFFFFFFF
        return A if (A >> 31) == 0x0 else A - (1 << 32)

    def computed(self, sel, A, B):
        A = A & 0xFFFFFFFF
        B = B & 0xFFFFFFFF
        match sel:
            case 0:
               return A + B
            case 1:
               return  A << (B & 0x0000001F)
            case 2:
               B = self.convert(B)
               A = self.convert(A)
               return 1 if A < B else 0 
            case 3:
                return 0
            case 4:
                return A ^ B
            case 5:
                 return A >> (B & 0x0000001F)
            case 6:
                return A | B
            case 7:
                return A & B
            case 8:
                 B = self.convert(B)
                 A = self.convert(A)
                 return (A * B) & 0x00000000FFFFFFFF
            case 9:
                B = self.convert(B)
                A = self.convert(A)
                return ((A * B) & 0xFFFFFFFF00000000) >> 32
            case 10:
                return 0
            case 11:
                return ((A *B) & 0xFFFFFFFF00000000) >> 32
            case 12:
                return A - B
            case 13:
                A = self.convert(A)
                return A >> (B & 0x0000001F )
            case 14:
                return 0
            case 15:
                return B
            case _:
                return 0


    def generate_test(self):

        with open("test.txt", "w") as file:
            for i in range(0, 16):
                alu_sel = i
                A = random.getrandbits(32)
                B = random.getrandbits(32)
                Expected = self.computed(i,  A, B) & 0xFFFFFFFF
                file.write(f"{format(alu_sel, '04b')} {format(A, '032b')} {format(B, '032b')} {format(Expected, '032b')}\n")
            A_0 = 0
            B_0 = 0
            alu_sel = 1
            Expected = 0
            file.write(f"{format(alu_sel, '04b')} {format(A_0, '032b')} {format(B_0, '032b')} {format(Expected, '032b')}\n")
            alu_sel_new = 12
            A_over = 0x80000000
            B_over = 0x00000001
            new_expected = self.computed(12, A_over, B_over) & 0xFFFFFFFF
            file.write(f"{format(alu_sel_new, '04b')} {format(A_over, '032b')} {format(B_over, '032b')} {format(new_expected, '032b')}\n")

            file.close()


g = Golden()
g.generate_test()
        
        
    