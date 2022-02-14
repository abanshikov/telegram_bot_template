from aiogram import types
from aiogram.dispatcher import FSMContext

from loader import dp


@dp.message_handler(state=None)
async def bot_echo(message: types.Message):
    """
    Эхо хендлер, куда летят текстовые сообщения без указанного состояния
    :param message:
    :return:
    """
    await message.answer(f"Простите, но я не знаю как обработать команду: \n"
                         f"{message.text}")


@dp.message_handler(state="*", content_types=types.ContentTypes.ANY)
async def bot_echo_all(message: types.Message, state: FSMContext):
    """
    Эхо хендлер, куда летят ВСЕ сообщения с указанным состоянием
    :param message:
    :param state:
    :return:
    """
    state = await state.get_state()
    await message.answer(f"Эхо в состоянии <code>{state}</code>.\n"
                         f"\nСодержание сообщения:\n"
                         f"<code>{message}</code>")
