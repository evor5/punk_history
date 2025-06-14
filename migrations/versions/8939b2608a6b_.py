"""empty message

Revision ID: 8939b2608a6b
Revises: b0732a6301c7
Create Date: 2025-06-08 16:33:15.521899

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '8939b2608a6b'
down_revision = 'b0732a6301c7'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('users', schema=None) as batch_op:
        batch_op.add_column(sa.Column('is_admin', sa.Boolean(), nullable=True))

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('users', schema=None) as batch_op:
        batch_op.drop_column('is_admin')

    # ### end Alembic commands ###
